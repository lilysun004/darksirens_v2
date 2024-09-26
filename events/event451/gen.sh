lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.950350350350348 --fixed-mass2 40.103863863863864 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002894743.577093 \
--gps-end-time 1002901943.577093 \
--d-distr volume \
--min-distance 2358.495854001759e3 --max-distance 2358.5158540017596e3 \
--l-distr fixed --longitude -17.9415283203125 --latitude -70.56597137451172 --i-distr uniform \
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
