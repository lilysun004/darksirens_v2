lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.134254254254255 --fixed-mass2 83.55463463463464 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006296457.8785388 \
--gps-end-time 1006303657.8785388 \
--d-distr volume \
--min-distance 1961.114283190478e3 --max-distance 1961.134283190478e3 \
--l-distr fixed --longitude -113.54872131347656 --latitude -21.08292007446289 --i-distr uniform \
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
