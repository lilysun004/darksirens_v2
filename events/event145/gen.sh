lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.92724724724725 --fixed-mass2 73.04912912912913 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026973922.076598 \
--gps-end-time 1026981122.076598 \
--d-distr volume \
--min-distance 3601.2054795921727e3 --max-distance 3601.225479592173e3 \
--l-distr fixed --longitude 127.80375671386719 --latitude -25.454174041748047 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
